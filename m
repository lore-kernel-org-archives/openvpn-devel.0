From: David Sommerseth <davids@...515...>
Date: Mon, 14 Aug 2017 18:12:14 +0200
Message-Id: <20170814161214.735-1-davids@...515...>
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
To: davids@...515...
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

This is the slightly modified commit, which resolves the merge conflict
when cherry-picking the corresponding commit from git master (c43045ca059).

Below is the complete commit message.

commit 5ed5030c349326c5448fd87424c1a2283ccee18f  (release/2.4)
Author: David Sommerseth
Date:   Mon Aug 14 15:19:37 2017 +0200

     sample-plugins: fix ASN1_STRING_to_UTF8 return value checks

     As we did in 2d032c7f for the ASN1_STRING_to_UTF8() calls in the core code,
     we should also free(buf) if the function returns 0.
    
     [DS: On-the-fly merge conflict fix:
          There was a conflict against the OpenSSL 0.9.6b workaround in v2.4.
          Since we no longer support anything older than OpenSSL 0.9.8 in
          release/2.4, whack that workaround and be more consistent with git
          master those two places]
    
     Signed-off-by: Steffan Karger <steffan.karger@...1435...>
     Acked-by: David Sommerseth <davids@...515...>
     Message-Id: <1501238302-16714-1-git-send-email-steffan.karger@...1435...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg15161.html
     Signed-off-by: David Sommerseth <davids@...515...>
     (cherry picked from commit c43045ca0590364552fbd060cc65ee1c50a4866a)


- --
kind regards,

David Sommerseth

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJZkcvWAAoJEIbPlEyWcf3yka4P/jCrg3SkgPEGZxmWOU4RGQlh
VSlcq64qKGggg7wEcG/G0UYCdiPwUT1zD0s/cFoJPNG/qSeX8D8LWOJosu41ISwH
aTU8j6oQ/WCA3xLbi9gLL67Aq7IlEoclQF56YUzAfyAYfF1eDmaJ2L8OlwYPlvQO
PAPYVKE/wHWXUaTa6xbgQJmL7evHg/Jr4ThnoOPGgrTwNPZFso4yrECd87wmhnXT
yjyypzrh/XEgQLMdo09LYyReLYAmOKx7BlmR9sXcp3JiXctwtd8//lSUoX8XrtlG
mNVzKBlWlzN4oPO0Llel33tuiSm4kGE7EQKbFzDx2Q6acEsvEmkVljILZ5Pe0MBi
wpT9hNcGr5/mImXEcm0Ga/z/qKLTlrgQJBiKmn6WOfaFFuGKWSqtN5MzpW1MPDwc
IUoPnlI/UaM86pLJqtq8+7/sAkM7V6H7zX9sMcz6JNi4HxdLIJg/ziL4qnRqU8ZA
88UOsY+2UnW4aJKZOkpNbGJiyUtUMn+NBwwd4tXsw5PXkh/Usjkyqhl5uGGTFEzu
rJgHkwE89R6C9NYEvzC5u85pe8yMZ/eJtywIwate+G7BST/KU98Bfyxbpe9eMjzo
qfewluWhHFzQaUSnSRk6jvzWCe3dr21nCyZM/ku9xKdI+vrmY0IwIjl8Haa2rAvD
VEXemEB5tgG8jxqPP7z7
=zosr
-----END PGP SIGNATURE-----

