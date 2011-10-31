From: Adriaan de Jong <dejong@...1435...>
Date: Mon, 31 Oct 2011 16:29:13 +0100
Message-ID: <1320074961-3809-1-git-send-email-dejong@...1435...>
MIME-Version: 1.0
Subject: [Openvpn-devel] Series of patches to fix Windows builds and other
	errors
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
To: openvpn-devel@lists.sourceforge.net

Hi,

The following series of patches enables Windows builds and fixes a few bugs
to boot. Most of it I'm quite comfortable with.

The only unfortunate thing in these patches is switching between OpenSSL
and PolarSSL. This currently requires changing two flags instead of one,
due to the build system. If anyone has any suggestions there, please let
me know.

Adriaan

---
[PATCH 1/8] Moved prng_uninit out of crypto_uninit_lib
[PATCH 2/8] Moved CryptoAPI header include to the ssl_openssl.c
[PATCH 3/8] Fixed missing comma in plugin.h
[PATCH 4/8] Reordered functions to ensure warning-free Windows build
[PATCH 5/8] Added options to switch between OpenSSL and PolarSSL and
[PATCH 6/8] Moved from strsep to strtok, for Windows compatibility
[PATCH 7/8] Minor cleanup to enable warning-free Windows build:
[PATCH 8/8] Fixed a typo when initialising cryptoapi certs

