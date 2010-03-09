Message-ID: <4B967465.3070909@...1114...>
Date: Tue, 09 Mar 2010 17:16:37 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1268150303.24740.2@...1207...>
In-Reply-To: <1268150303.24740.2@...1207...>
Subject: Re: [Openvpn-devel] Supporting "route-gateway dhcp" on non-Windows
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: "Karl O. Pinc" <kop@...1206...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>, James Yonan <jim@...41...>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 09/03/10 16:58, Karl O. Pinc wrote:
> On 03/09/2010 08:05:17 AM, David Sommerseth wrote:
> 
>>  On the other hand, ./configure
>> could try to detect which DHCP client the system got and could use
>> that
>> as a default client to kick off.
> 
> I think this might cause more problems than it solves because
> there's no guarantee that build hosts will have the same,
> or any, dhcp client that is ultimately used.   
[...snip...]

Agreed.  Not ideal situation, especially if you can not configure an
override.

> Maybe what makes the most sense from a package
> management standpoint is to have the package installation
> process autodetect the existing dhcp client so that whatever
> the user has installed will be used (once the feature
> is turned on with --route-gateway.)  I'm not sure how
> to best facilitate this with OpenVPN.  Perhaps OpenVPN
> should default to using something like
> /etc/openvpn/route-gateway-dhcp-client and then
> package installation can softlink that to whatever
> dhcp client is installed.  

A symlink like this also then requires the current (and future) DHCP
clients to use the same arguments.  People would then replace this with
a script of course.  But then this script can be used to do more nasty
things than what it is intended for, so then you have a possible
security issue again.  Is this really an approach we want to use?

Actually this issue will always be present, as long as third party
applications are exec()ed from OpenVPN.  We already got plenty of script
hooks available, do we really want or need one more?  And do we want one
which will need to have root access on most platforms when the tap
device is being teared down?

> Over-automating things will cause people headaches.
> You don't want to willy-nilly startup a dhcp client
> and have all your interfaces configured with dhcp without
> your consent.

Exactly!  Which again moves it more in the direction of some built-in
DHCP client in OpenVPN, but as stated earlier - that mostly solves the
core DHCP issues - but not the resolv.conf issue.

And by doing it this way (embedded DHCP client), we could maybe even
make this work with tun devices as well, if the server then can act as a
DHCP relay against a real DHCP server.


kind regards,

David Sommerseth

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkuWdGMACgkQDC186MBRfrrI0gCgkPt63MTUc2yFimrkWRG9VKzQ
8D8An1vidIoFp2SivjySNExpqvyvc928
=CAOE
-----END PGP SIGNATURE-----

