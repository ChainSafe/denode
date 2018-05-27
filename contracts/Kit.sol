pragma solidity ^0.4.18;

import "@aragon/os/contracts/factory/DAOFactory.sol";
import "@aragon/os/contracts/apm/Repo.sol";
import "@aragon/os/contracts/lib/ens/ENS.sol";
import "@aragon/os/contracts/lib/ens/PublicResolver.sol";
//import "@aragon/os/contracts/apm/APMNamehash.sol";

import "@aragon/apps-voting/contracts/Voting.sol";
import "@aragon/apps-token-manager/contracts/TokenManager.sol";
import "@aragon/os/contracts/lib/minime/MiniMeToken.sol";

import "./App.sol";

contract KitBase {
	ENS public ens;
    DAOFactory public fac;

    event DeployInstance(address dao);
    event InstalledApp(address appProxy, bytes32 appId);

    function KitBase(DAOFactory _fac, ENS _ens) {
    	ens = _ens;

    	// If no factory is passed, get it from on-chain bare-kit
    	if (address(_fac) == address(0)) {
    		bytes32 bareKit = keccak256("bare-kit");
    		fac = KitBase(latestVersionAppBase(bareKit)).fac();
    	} else {
    		fac = _fac;
    	}
    }

	function latestVersionAppBase(bytes32 appId) public view returns (address base) {
        Repo repo = Repo(PublicResolver(ens.resolver(appId)).addr(appId));
        (,base,) = repo.getLatest();

        return base;
    }
}

contract Kit is KitBase {
	MiniMeTokenFactory tokenFactory;

	uint256 constant PCT = 10 ** 16;
	address constant ANY_ENTITY = address(-1);

	function Kit(ENS ens) KitBase(DAOFactory(0), ens) {
		tokenFactory = new MiniMeTokenFactory();
	}

	function newInstance() {
		Kernel dao = fac.newDAO(this);
        ACL acl = ACL(dao.acl());
        acl.createPermission(this, dao, dao.APP_MANAGER_ROLE(), this);
        //startApp(dao, acl);
    }

   /* function startApp(Kernel dao, ACL acl) internal {
		bytes32 appId = keccak256("app");
		bytes32 votingAppId = keccak256("voting");
		bytes32 tokenManagerAppId = keccak256("token-manager");

		App app = App(dao.newAppInstance(appId, latestVersionAppBase(appId)));
		NodeRegistry nodeRegistry = NodeRegistry(dao.newAppInstance(appId, latestVersionAppBase(appId)));
		ClientRegistry clientRegistry = ClientRegistry(dao.newAppInstance(appId, latestVersionAppBase(appId)));
		VerifierRegistry verifierRegistry = VerifierRegistry(dao.newAppInstance(appId, latestVersionAppBase(appId)));

		Voting voting = Voting(dao.newAppInstance(votingAppId, latestVersionAppBase(votingAppId)));
		TokenManager tokenManager = TokenManager(dao.newAppInstance(tokenManagerAppId, latestVersionAppBase(tokenManagerAppId)));

		MiniMeToken token = tokenFactory.createCloneToken(address(0), 0, "App token", 0, "APP", true);
		token.changeController(tokenManager);

		tokenManager.initialize(token, true, 0, true);
			// Initialize apps
		voting.initialize(token, 50 * PCT, 20 * PCT, 1 days);
		createPermissions(dao, acl, msg.sender, voting, tokenManager);
	}

	function createPermissions(Kernel dao, ACL acl, address root, Voting voting, TokenManager tokenManager) internal {
		
		acl.createPermission(this, tokenManager, tokenManager.MINT_ROLE(), this);
		tokenManager.mint(root, 1); // Give one token to root

		acl.createPermission(ANY_ENTITY, voting, voting.CREATE_VOTES_ROLE(), root);

		//acl.createPermission(voting, app, app.INCREMENT_ROLE(), voting);
		//acl.createPermission(ANY_ENTITY, app, app.DECREMENT_ROLE(), root);
		acl.grantPermission(voting, tokenManager, tokenManager.MINT_ROLE());

		// Clean up permissions
		acl.grantPermission(root, dao, dao.APP_MANAGER_ROLE());
        acl.revokePermission(this, dao, dao.APP_MANAGER_ROLE());
        acl.setPermissionManager(root, dao, dao.APP_MANAGER_ROLE());

        acl.grantPermission(root, acl, acl.CREATE_PERMISSIONS_ROLE());
        acl.revokePermission(this, acl, acl.CREATE_PERMISSIONS_ROLE());
        acl.setPermissionManager(root, acl, acl.CREATE_PERMISSIONS_ROLE());

        DeployInstance(dao);
	}*/
}