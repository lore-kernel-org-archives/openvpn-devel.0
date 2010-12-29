Message-ID: <4D1BC2B1.9070705@...1114...>
Date: Thu, 30 Dec 2010 00:22:25 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <20101223060056.GF2794@...1442...>
In-Reply-To: <20101223060056.GF2794@...1442...>
Subject: Re: [Openvpn-devel] CBC mode attack
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: travis+ml-openvpn-devel@...1442...
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 23/12/10 07:00, travis+ml-openvpn-devel@...1442... wrote:
| Hey guys...
|
| Was wondering if you were familiar with this:
|
| http://news.ycombinator.com/item?id=2029640
|
| And, well... it sounded really familiar:
|
| http://www.mail-archive.com/cryptography@...1443.../msg07521.html

Well, of course this is really concerning stuff.  But the reality is that
OpenVPN depends 100% on OpenSSL to do all the encryption stuff.  OpenVPN does
not do anything extra to the core data encryption or algorithms involved.

So, if OpenVPN got an issue here ... then OpenSSL got an even bigger issue, as
all who depends on OpenSSL might be at risk.  And this mailing list can mostly
just cover the former and not the latter.


kind regards,

David Sommerseth



-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAk0bwrEACgkQDC186MBRfrqQOwCdEhhQ3Zq814CdGTnI+DDK/xja
xxkAn1grNJ7mxgeQHILpaVW60Uf/YWRs
=B0Ve
-----END PGP SIGNATURE-----

