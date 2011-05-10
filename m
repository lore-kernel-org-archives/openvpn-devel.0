Message-ID: <4DC94AB2.6030008@...1114...>
Date: Tue, 10 May 2011 16:24:50 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <4DC936F3.6000509@...1458...> <4DC93E4C.5070606@...1147...>
	<20110510133830.GD8496@...1296...>
In-Reply-To: <20110510133830.GD8496@...1296...>
Subject: Re: [Openvpn-devel] Fwd: OpenVPN netsh.exe patch
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
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 10/05/11 15:38, Gert Doering wrote:
> I have not yet tested this, but Seth has, both on XP and Win7, so "ACK!"...

Windows XP SP2 is tested ... what about older XPs?  Personally, I am in
favour of only supporting Windows versions which Microsoft officially supports.

<http://windows.microsoft.com/en-us/windows/products/lifecycle>

Windows XP SP2 was supported until June 13, 2010.  Now only Windows XP SP3
is supported.

> David: I think it's easiest in this case if I integrate it, and then send
> it to you.  It needs to go to my "based on 2.2" branch as well.

It doesn't matter for me.  You either pull it in, and I merge in your tree.
 Or I pull it in and you rebase your 2.3 working branch against my master
and then you can cherry-pick this commit for your IPv6 2.2 branch.


kind regards,

David Sommerseth

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAk3JSrIACgkQDC186MBRfrp9MwCgk/df5IPuAEoTZS3vse6TjDX3
JaAAoJNPMglECeeC6flBczbRhT0An9cx
=MmyN
-----END PGP SIGNATURE-----

