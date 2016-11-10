References: <1476996158-5390-1-git-send-email-davids@...515...>
	<b76abfb0-7ed3-b0ee-61db-2dba94390e4e@...277...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <2a0d57a8-d80d-a877-8e3c-48e234f9849a@...2080...>
Date: Thu, 10 Nov 2016 13:16:39 +0100
MIME-Version: 1.0
In-Reply-To: <b76abfb0-7ed3-b0ee-61db-2dba94390e4e@...277...>
Subject: Re: [Openvpn-devel] [PATCH] systemd: Improve the systemd unit files
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: debbie10t <debbie10t@...277...>, openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 10/11/16 02:11, debbie10t wrote:
>=20
>=20
> On 20/10/16 21:42, David Sommerseth wrote:
>=20
>> [Service] PrivateTmp=3Dtrue +RuntimeDirectory=3Dopenvpn=20
>> +RuntimeDirectoryMode=3D0710 +WorkingDirectory=3D/etc/openvpn/server=20
>> +ExecStart=3D/usr/sbin/openvpn --status
>> %t/openvpn/server_%i-status.log --status-version 2
>> --suppress-timestamps --config %i.conf
>=20
> --status appears to cause many problems, why is it specified here
> ?

It is fairly common to have on server configurations, and several
distributions already have this in their sysv based init scripts.  So
this just follows that tradition.

If a user wants to use a different status file, adding 'status
/var/log/my-own-status.txt' will override the system default.

This status-file is fairly consistent in the file size, so unless you
have a many thousand users connected to the same OpenVPN daemon the
file size will be insignificant.  As an example, 2 connected clients
with 8 routes each is roughly 2.5KiB.  So with 100 clients having 16
routes would most likely be around 0.5MiB of data.

I don't know quite what you mean with 'cause many problems'.  If you
are referring to the debian 8 testing and changing RuntimeDirectory to
point at openvpn-server, then --status needs to be similarly changed,
to be: %t/openvpn-server/server_%i-status.log

If you could please add more details to what goes wrong (log data), it
is far easier to understand what is going on.

- --=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJYJGUmAAoJEIbPlEyWcf3yyPQQALAtdjX1EN6hwZpFTdazD/Zc
GkuehDfYiywdGZBXaSU7Qm74CRcNltub7rEvTfTMa/zqys1FDyExTFJtJBT+CCZS
NEN6Wkd5lCiIhQdvk84Og/OpOBp+ob6sBo9VCgGS6I8uannmrvb3cCcFZax8CE47
SqOHspOE/oBT+eXGw6GmIA4m08kqtKL5f92rxK+Jc3bWiQ7nhJ831jZGBlS+XTec
S9w225q8goyFea4I4XQUCECHviD116IB461HcNp0CvCos6BPLHR7xdBc3es4kwUc
Hs5lQvLPZxmCwRitTdUu2NiAxHM33PJRNvGwlXjS7mnbSOgQ8cjMrFyE2RlrEtPB
FtEbM82OO5UsZV+PxAPy6r48k9mAOgKz9RrvoKAwvHcQQ+mndU9akewntU2+aMSq
ixsgrT78P3HTteAphJfLOQKORwmzC4oARbjtW6I15JNrEg4+C3Z0n3Tc6DydFKJ2
axcUCuFdAwb+qSeIE+VmMhCf1lfHoMCGp63TyNrfDImkfgoV+kpl5fGURfmX2Dyx
DT7liTm5nGp99SxKRD3hpujmdJL05lE+pyHmeq0LTIGbcoUisMpfodVdWgomg3y1
BuVamoiKE0dqU3JZErqtZt6oiAxyihMatll1W3RC17TVssEZXG73D/mhDr/wFxod
pTsQFdP5jsmZ2SqEeBlD
=3Dorrg
-----END PGP SIGNATURE-----

