From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <2b9ae1ef-05fc-6631-38ff-c355bedc6c7b@...515...>
Date: Tue, 28 Nov 2017 16:47:01 +0200
MIME-Version: 1.0
Content-Language: en-US
Subject: [Openvpn-devel] Vagrant-based OpenVPN build environments now
 available
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

Hi all,

It is now possible to easily test building of OpenVPN on various
operating systems using Vagrant and Virtualbox:

<https://github.com/OpenVPN/openvpn-vagrant>

All the build dependencies get installed during VM provisioning. Right
now the following operating systems are supported:

centos-7
debian-9
freebsd-11
openbsd-6
ubuntu-1604
netbsd-7
solaris-113 (see recipes/Solaris113.txt)

The goal is to allow any developer to test his code on platforms other
than his/her own.

There is also a VM called "openvpn-build". It can be used to
cross-compile OpenVPN for Windows.

We plan to provide a test server VM next. It will run several OpenVPN
server instances with varying configurations, something akin to current
t_client test server. Later on we will attempt to integrate "testing:
Add vagrant based integration tests" PR[1] to this new repository. This
will make testing more automatic. At this point the setup will be quite
similar to Buildbot, but usable by "external" developers also.

The provisioning scripts in the repository can also be used to configure
more long-running test instances: there is nothing inherently
Vagrant-specific in them.

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

[1] <https://github.com/OpenVPN/openvpn/pull/45>

