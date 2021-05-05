MIME-Version: 1.0
References: <CAGyAFMUg4+nsVGpjFiEBiJf4nP7BqvhRv6GC7jXBp20ef49HZA@...278...>
In-Reply-To: <CAGyAFMUg4+nsVGpjFiEBiJf4nP7BqvhRv6GC7jXBp20ef49HZA@...278...>
From: Lev Stipakov <lstipakov@...277...>
Date: Wed, 5 May 2021 10:36:04 +0300
Message-ID: <CAGyAFMUgrb-asi-Tp+RwT1wLnEFUJwjywzbS6HYyM_AyrU==ow@...278...>
Subject: [Openvpn-devel] Fwd: Introducing the OpenVPN Data Channel Offload
 Windows driver
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>, openvpn-users@lists.sourceforge.net

Hello all,

I would like to announce a new version of "ovpn-dco-win"-enabled
client. Here are some changes from the previous version:

1) MSI based installer. This makes upgrades from existing
installations more smooth, since starting from version 2.5 openvpn has
switched to MSI.

  - ovpn-dco-win driver is installed only on Windows 10 2004 and
newer, on other versions the driver feature won't be even visible in
installer dialog

  - (un)installer should correctly handle cases when ovpn-dco-win
adapter is in use. It shuts down openvpn service and, if that doesn't
help, prompts to
reboot at the end of (un)installation

  - driver is deleted from Windows driver store on uninstallation

2) Fixes to the driver itself:

 - control packets from the previous VPN session could be delivered to
a client which has started a new VPN session. This happened
in rare cases when control packets were read by the driver from the
network and the app hasn't issued read requests

 - crypto: when adding a new key, data channel packet-id hasn't been
re-initialized. In some cases this caused VPN session to stop
functioning
after key renegotiation

3) The client code is based on the latest version of Arne Schwabe's
dco branch (https://github.com/schwabe/openvpn/tree/dco, commit
ceefcaf),
which, comparison the previous version, includes deferred
authentication improvements, openvpn state machine refactoring and
many other nice things.

The signed installation package could be downloaded from
https://build.openvpn.net/downloads/snapshots/OpenVPN-2.6-dco-win-preview-amd64.msi

The driver repo is hosted here: https://github.com/openvpn/ovpn-dco-win

As before, to enable ovpn-dco-win driver, add following options to the
ovpn profile:

    windows-driver ovpn-dco-win
    tun-mtu 1428

Please give it a try (since this is a feature preview, avoid
installation on production systems) and report your feedback
(especially performance improvements if you notice any) to help us get
ovpn-dco-win into the next major release.

-- 
-Lev

