Message-ID: <4E0D84B5.9070108@...1114...>
Date: Fri, 01 Jul 2011 10:26:29 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1309335848-14414-1-git-send-email-samuli@...515...>	<1309420750-26524-1-git-send-email-samuli@...515...>
	<4E0C3D87.6050407@...68...>
In-Reply-To: <4E0C3D87.6050407@...68...>
Subject: Re: [Openvpn-devel] [PATCH] Fixes to easy-rsa/2.0
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Matthias Andree <matthias.andree@...68...>
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 30/06/11 11:10, Matthias Andree wrote:
> Am 30.06.2011 09:59, schrieb samuli@...515...:
>> From: Samuli Seppänen <samuli@...515...>
>>
>> As support for OpenSSL 1.0.0 requires a modified openssl.cnf file, it was
>> decided to rename openssl.cnf to openssl-1.0.0.cnf for clarity and better
>> support of different OpenSSL versions. The old openssl.cnf was renamed as
>> openssl-0.9.8.cnf.
> 
> But: Whence the need to keep support for 0.9.6?
> 

Agreed, and we decided yesterday in the developers meeting to remove 0.9.6
support.  However we found it better to remove that support first in
OpenVPN 2.3, as we will then go through the source code and remove all
0.9.6 related stuff in the same go.  We don't want to change this in a
stable release.


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAk4NhLIACgkQDC186MBRfrqaewCgiuSHDJhwc4pA9U0uSxNij5tM
WCsAn0cA50Ya0F9zy/pqMGj4wxzkxSqr
=9kuQ
-----END PGP SIGNATURE-----

