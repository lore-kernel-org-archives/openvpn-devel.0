Sender: Emmanuel Deloget <emmanueldeloget53@...277...>
From: Emmanuel Deloget <logout@...260...>
Date: Fri, 12 Jan 2018 17:48:22 +0100
Message-Id: <cover.1515775195.git.logout@...260...>
Subject: [Openvpn-devel] [PATCH 0/3] Fix EVP_PKEY key types handling
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
To: openvpn-devel@lists.sourceforge.net

Hello, 

The dubious commiter of the OpenSSL 1.1 changes got it wrong again. 
Not sure if I can trust this guy. Not to mention that he pretends to 
be /me/... :)

Anyway, I fixed some of his mistakes again.

For reference, this fixes a bug reported by Selva (hence the Reported-By 
tag on the first patch) where openvpn crashes when it's feeded with an 
ECC key (same bug shall arise when using a DSA key).

The first patch in the series is necessary (it's the one that fixes 
the bugs). Patch 2 remove code that is no longer necessary. Patch 3
then remove an entire function which is no longer used (although I'd 
understand if one wants to keep this function around).

Hopefully, this is the last time I have to correct a bug by the previous 
commiter (I will not name him. That would sound too weird). Next time, 
he'll have to do it by himself :)

Best regards, 

-- Emmanuel Deloget

Emmanuel Deloget (3):
  OpenSSL: check EVP_PKEY key types before returning the pkey
  OpenSSL: remove some EVP_PKEY type checks
  OpenSSL: remove EVP_PKEY_id()

 configure.ac                 |  1 -
 src/openvpn/openssl_compat.h | 20 +++-----------------
 src/openvpn/ssl_openssl.c    | 33 +++++++++++++++++----------------
 3 files changed, 20 insertions(+), 34 deletions(-)

-- 
2.11.0


