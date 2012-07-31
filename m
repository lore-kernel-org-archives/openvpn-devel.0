Message-ID: <5017CC12.9000709@...1114...>
Date: Tue, 31 Jul 2012 14:14:10 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1343666121-19765-1-git-send-email-heiko.hund@...1489...>
	<5016BEFA.8030901@...1114...> <1738242.yJcaVCkhX0@...1526...>
In-Reply-To: <1738242.yJcaVCkhX0@...1526...>
Subject: Re: [Openvpn-devel] [RFC] give plugins a method to pass log lines
 to openvpn
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Heiko Hund <heiko.hund@...1516...>
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 31/07/12 13:31, Heiko Hund wrote:
>> But it should also prefix these log lines as coming from a
>> plug-in (preferably with the plug-in name included)...
> 
> I don't think enforcing something like this makes much sense, as
> evil plugins, trying to forge log lines to appear originating from
> the core process, will just call x_msg() directly then.

Agreed, the intention wasn't to nail evil plug-ins, it was more a
convenience - as the plug-in itself doesn't need to "identify" itself.
 The plug-in cares for what it wants to add to the log, and the rest
is automatic and will also be "tagged" consistently among all plug-ins.

- From another point of view, an evil plug-in would have to know/figure
out the address to x_msg() ... so that would require a bit more work,
at least to work against different distro/compiler/linker
combinations, as it's not given the address will be the same.
However, it's not necessarily hard to figure it out, but requires more
work.  And an evil plug-in would anyway need to first be installed
somehow too.  So I consider this attack vector less attractive.

And, AFAIK, you can't use dlsym() without a handle to a shared lib
opened with dlopen().  And I don't think you can't export the log
function in the openvpn-plugin.h file as an external function, as the
plug-in would fail to link (I would expect the linker wouldn't find
the required symbol) ... which then brings us back to the point where
you need to send a pointer to the log function to the plug-in ...
That's basically how I came to this conclusion.


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlAXzBAACgkQDC186MBRfrrDDgCfdGlu8GK4oD4aELiskzgqmoXm
yoIAni0vANC55rDK3AtV9BqIlaTtx0gj
=ezeg
-----END PGP SIGNATURE-----

