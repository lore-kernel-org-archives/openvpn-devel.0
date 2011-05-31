Message-ID: <4DE50E52.2000509@...1114...>
Date: Tue, 31 May 2011 17:50:42 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <4DB864E0.4060207@...515...> <4DE4F116.2000904@...1030...>
	<4DE502D5.3070403@...1114...>
	<4DE504BA.6060209@...1030...>
In-Reply-To: <4DE504BA.6060209@...1030...>
Subject: Re: [Openvpn-devel] OpenVPN 2.2.0 build failure
	with	"--disable-management"
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
To: Mr Dash Four <mr.dash.four@...1030...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 31/05/11 17:09, Mr Dash Four wrote:
> 
>> Quick fix: add --disable-pkcs11 in addition to --disable-management
>>
>> Can you try to apply the attached patch?  I believe that might solve your
>> compile issues.
>>   
> Many thanks - I think applying the patch would be easier (I'll just list it
> in the .spec file and include it during the rpm build) - I take it that
> would solve the above. I'll let you know when I try this later tonight.

Yes, this patch should hopefully solve it.

It seems like pkcs11.c was missing some header files which the management
interface includes.  When you disable the management API, these include
files is missing and it collapses.

If this works for you, I'll take this as an ACK from you, then this patch
will get into the queue for a 2.2.1 release.


Kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAk3lDlIACgkQDC186MBRfrqU/wCfRHrJreXpOeAcMS5ZbHrpUg5Q
dlsAnj7iXiiMWYIa2CmyH7gm07X/EnnK
=I/lp
-----END PGP SIGNATURE-----

