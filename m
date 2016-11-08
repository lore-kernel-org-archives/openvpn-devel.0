References: <1476996158-5390-1-git-send-email-davids@...515...>
	<88fab532-d93c-e65b-a604-eacfb888da74@...277...>
	<196da459-e0aa-6ee9-b14e-786398ebd928@...2080...>
	<20161108210213.qntt5o6uiikkk4eg@...30...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <1b1b371b-d477-06c4-e6a0-39f59f47d8f5@...2080...>
Date: Tue, 8 Nov 2016 22:14:57 +0100
MIME-Version: 1.0
In-Reply-To: <20161108210213.qntt5o6uiikkk4eg@...30...>
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
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 08/11/16 22:02, Alberto Gonzalez Iniesta wrote:
> On Tue, Nov 08, 2016 at 09:27:20PM +0100, David Sommerseth wrote:
>> On 08/11/16 16:40, debbie10t wrote:
>>> Hi,
>>> 
>>> I now have these unit files working on all my test VMS.
>>> 
>>> The only problem before was that on debian 8 these services
>>> failed to start after reboot. (systemctl enable
>>> openvpn-{client/server}@config was enabled) The error message
>>> was: main process exited, code=exited,
>>> status=233/RUNTIME_DIRECTORY
>> 
>> It sounds like there's a conflict with a pre-existing directory.
>> 
>> Do you have a chance to check if the stock openvpn version you
>> had installed ships with a pre-created /var/run/openvpn
>> directory?  (or /run/openvpn, or whatever Debian uses as the
>> runtime directory)
>> 
>> Otherwise, great testing!
>> 
> 
> The Debian package creates /run/openvpn/. /var/run is a symlink to
> /run in Debian.

Alright ... we can then consider to use

    RuntimeDirectory=openvpn-{client,server}

That should not collide.  Any chance you can test that, debbie10t?
Just change the RuntimeDirectory= to a directory not existing in
{,/var}/run.


Thanks for the feedback, Alberto!


- -- 
kind regards,

David Sommerseth
OpenVPN Technologies, Inc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJYIkBRAAoJEIbPlEyWcf3y7QcQAKPoQiZoNGJ5ux+f3uqwK98q
6V7aICnDJKRopJZrvbFNhGPhlS0+rU4ZrHnupqzn2Klv9SmtY7BU/R4Iys1R3/y8
ZIGAlguQyHUzxmuiV+0C2yc5Z0ccllbik6ECHzSmy6cDAu6byWDFk6jumcubTo6F
oK68D3bOW2Dlo59OChBHTTft3Wm74/LifVHITTp9sNKxUgYdnjA7j7YxDk/G9EUg
ASpyUFU16EA4SjLZJLdTU9UUZDmMW2UjEHNOF0uxLou02ryao5L3tZ5y66upv3oc
IeL5J++w0pKg8O7E59pchsRQUnfGiNH/H4uw/cfc2wfnzGRe8Trd9x9wwoW0wtv/
ET6t3/IFm6XIvmSEHFXHlR4kjoGXn21jD7LkYZ9LRUARX8Ca7pZDddqkShkX2/Ds
XV7TCjnxhgrXmIAaenLIyLj40wmVBLN1QAczaASP3uh0hnOp8o3K0DEu1ddBooKr
NaJmFEmUQsUC5gO+jf0Px6d8ZWAwHxn4+PYRUfx8v/g2ECVL3Up6omwmDjwzZ1O4
iL/mKgfwypy0nFIfEYUs4s5dFmNKnOTMaykh2syUPj5ApuAqlZiCH5C9/LR3OZXe
mQBcuAoOfAHzsHtvudfzj89MKmK3AcGWzkcfbVZQpq4JbD//ezSbo45aufCJU5x7
b23T8cinrbbrrEKX0HQj
=Dzuy
-----END PGP SIGNATURE-----

