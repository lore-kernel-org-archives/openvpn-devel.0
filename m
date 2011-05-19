Message-ID: <4DD5432E.7070003@...1114...>
Date: Thu, 19 May 2011 18:19:58 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <BANLkTimDEA004RuTcUBKDXPWffEWBo3-iw@...278...>
	<4DD54252.90405@...1114...>
In-Reply-To: <4DD54252.90405@...1114...>
Subject: Re: [Openvpn-devel] [PATCH] fix 2.2.0 build failure when management
 interface disabled
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
To: openvpn-devel@lists.sourceforge.net, "Matthew L. Creech" <mlcreech@...277...>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 19/05/11 18:16, David Sommerseth wrote:
> On 11/05/11 23:57, Matthew L. Creech wrote:
>> Hi,
> 
>> I just upgraded to 2.2.0, and my build fails with:
> 
>> ps.c: In function 'port_share_open':
>> ps.c:778:7: error: 'management' undeclared (first use in this function)
>> ps.c:778:7: note: each undeclared identifier is reported only once for
>> each function it appears in
>> make[5]: *** [ps.o] Error 1
> 
>> The attached patch fixed the problem.
> 
> Hi,
> 
> Thanks a lot for your patch.  Your patch is applied to master and
> cherry-picked for the next 2.2 release.
> 
> commit 76ef46144f7e3ecc760dcb9f25a7ecb769d39c59 (master)
> commit e7fa867d2685e6c455ce49042d4c0cbffdd68ff9 (release/2.2)
> Author: Matthew L. Creech <mlcreech@...277...>
> Date:   Wed May 11 17:57:28 2011 -0400

Sorry!  I need to revert this patch.  You use MANAGEMENT_ENABLED, but it
should be ENABLE_MANAGEMENT.  I just noticed it now.  I'm sorry for the
noise, I'll fix this and apply it again.


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAk3VQy4ACgkQDC186MBRfrocnQCfajQRGiazSBJWdaLEzsA2vyDU
besAni8qtMGT/1vKcABt8qQAYs2asf/G
=McOO
-----END PGP SIGNATURE-----

