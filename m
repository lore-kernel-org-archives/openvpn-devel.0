From: David Sommerseth <davids@...515...>
Date: Mon, 14 Aug 2017 15:58:16 +0200
Message-Id: <20170814135816.22191-1-davids@...515...>
In-Reply-To: <1501238302-16714-1-git-send-email-steffan.karger@...1435...>
References: <1501238302-16714-1-git-send-email-steffan.karger@...1435...>
Subject: Re: [Openvpn-devel] [PATCH applied] sample-plugins: fix
 ASN1_STRING_to_UTF8 return value checks
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: steffan.karger@...1435...
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

ACK.  I have a slightly modified version of this patch pending for
release/2.4 (which lacks the OpenSSL 0.9.6b workaround removal).  This
will be considered to be added a bit later.

Your patch has been applied to the master branch

commit c43045ca0590364552fbd060cc65ee1c50a4866a
Author: Steffan Karger
Date:   Fri Jul 28 12:38:22 2017 +0200

     sample-plugins: fix ASN1_STRING_to_UTF8 return value checks

     Signed-off-by: Steffan Karger <steffan.karger@...1435...>
     Acked-by: David Sommerseth <davids@...515...>
     Message-Id: <1501238302-16714-1-git-send-email-steffan.karger@...1435...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg15161.html
     Signed-off-by: David Sommerseth <davids@...515...>


- --
kind regards,

David Sommerseth

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJZkax0AAoJEIbPlEyWcf3ytLkQAIojuE34qq8HN2UTkIPoEDNz
/LUzFJjLovzMEibI3Q1g8h3MkSlEi0ar6CHo1X4q4uXoD6dkb6K7Ccy2iU4HglqU
rQtrjU/0tC/iVHmdRayhJc7aez4QIbovIfRuamA0dqC4zoEZutMRrbHF4prRy7Lc
VFprsfEjJPV8yRvEfU34PWHaxFehU8l/9P530oMPeO+mFG0oKP7FCaYbgmV9KZLF
CxjbHY8ZdEXQ++GBmKa/vklsdxb+QF03OoDTmNvqM5YqaCHsWkAxesu5ESwpJomC
pkfG2dSd/0WZI8vuw02sgOAGDPXx5+rNSFpg2eDbynhC1w30lk9w5e281ViyDMcl
h1DrLyP+MTMhIPYYQ5bZSwyct5Mwao+biGxdFmtnTOn1zWrG4M8d4uSA6Sf0pu2b
/u+68KxrHG5/yra3RyTTIza4fCdLUVriepAQAqtHXlPSyGwKS8/eFzlzrFbFhEa8
iDeHJvtQSyPQvt/N3sprvtIKnv88GS3orrpEdDtFJYL2KSVJ4eb2mXKgYqkSDhL0
2KADnwl9cOmiHKBYKPq515GI6b6i63CmLmO32wXh44yU00k26vLfEX8s3ItOWlRD
eJi7t1R8sZm1IJWmZM3AHsv+5h+Kn84f8YZit/fiZJivIREMb5LAVS/h9ZqBMyNX
4LgYGutbSjKU+fSrG2JB
=KULp
-----END PGP SIGNATURE-----

