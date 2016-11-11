References: <1476996158-5390-1-git-send-email-davids@...515...>
	<6c3649c3-75e0-df8a-d910-73441af695d9@...515...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <a2f226df-89b0-f8de-0af1-225351a90edd@...2080...>
Date: Fri, 11 Nov 2016 13:35:57 +0100
MIME-Version: 1.0
In-Reply-To: <6c3649c3-75e0-df8a-d910-73441af695d9@...515...>
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
To: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>, David Sommerseth <davids@...515...>, openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 11/11/16 13:28, Samuli Sepp=E4nen wrote:
> This comes a bit late, sorry.
>=20
> Il 20/10/2016 23:42, David Sommerseth ha scritto:
>> There are several changes which allows systemd to take care of
>> several aspects of hardening the execution of OpenVPN.
>>=20
>> - Let systemd take care of the process tracking directly,
>> instead of doing that via PID files
>>=20
>=20
> This makes sense, but it has one caveat. If there is no pidfile,=20
> external, local monitoring applications might not be able to
> monitor the status of the OpenVPN process anymore. I, for example,
> heavily utilize monit for it's email notification capabilities, and
> because it can actually do things if it detects anomalies.
>=20
> The last time I checked, there is no easy way to get systemd to
> notify the admin if, say, a daemon goes down and systemd restarts
> it. Is this still the case?

Systemd will in this case mark the service as "Failed" and the status
message will try to give an indication of what happened - was the
process killed, segfault, stopped with an exit code, etc.

For external tools, you can now actually add the PID file yourself via
the configuration file, and place the PID file exactly where it fits
your need.  So this actually gives a far better flexibility.

We can of course investigate if we should enable systemd to restart
OpenVPN, at least the server profile, if it dies unexpectedly.
Currently, I am not fully convinced we want that.


- --=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJYJbstAAoJEIbPlEyWcf3yTEUQAMFkuQ+9wBYvLVqIilcPBEtL
gM6rFzmtmQO9HkJnE5DdxxCLTPQu2FDpH66QxUOOkQgilji2iuub0L5ebo/yhfKH
+mKCnn56553kcFSYozDDiW3S0nulCjDGZ3/dWh/jjnVbthpdnigpFswEaTfJsTn8
ZQ7Uw6rIN4ocqsySLDhTdVaxzcEE3tLXpxsvh7cqGrY7gdodxQfZ6guIN2jNpgOW
vzKTr/oDbLl7mfE/yCIahH2b++rIWezPwcdXccQdCs1EiadQLwpTm7YCkc+RGXH6
cYANjeXzBCMUqb+PceRcNBgxQy+6Bo3zBNh5UC3eVcitc9I/3fAxZ+7z3H+Yacyq
bOX5RGU2vjDO6M1SBtvS3fPSKAIj/yL9DxWmeOyYWJwqSXcixdXBmBtprulMhR1p
LdO/Fj95onek2qeXQOuoppQO5bUu71r5OwoYmDi/BGKDvIbU7r4watNfHM8v6fiR
WU4JFMGIvK0oXknv2LJUDpPjyOlMwty9y+aTIPNr+TrxEKzE9PjbfVRpCsNSDJxq
W4iYZV0qS4OPJl2fHdZeX7bPxeyYsoZ6Qn2qf7QKLB6SQeEheWxeEl4JsBHgvlbO
4RgVBFJSGVKhgz7pjpYEDVXyBOCKidUBjiIDXyC5C8phIniFQb5umNDFC/6i8Deh
AkfV28b/RdHq+/TUfLq+
=3DtTI/
-----END PGP SIGNATURE-----

