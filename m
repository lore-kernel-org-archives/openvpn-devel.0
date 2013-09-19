From: <steffan.karger@...1435...>
Date: Thu, 19 Sep 2013 12:47:26 +0200
Message-ID: <1379587649-25506-1-git-send-email-steffan.karger@...1435...>
MIME-Version: 1.0
Subject: [Openvpn-devel] --management-external-key for polarssl
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

These three patches add --management-external-key support for polarssl builds. 
The code was originally written by Joachim Schipper for OpenVPN-NL, which is why
he is mentioned as the author of the patches. I reworked it a bit to match the
regular OpenVPN codebase better. 

Patch 1/3 is just a bit of preparation for patch 2/3.

Patch 2/2 adds the --management-external-key functionality. 

Patch 3/3 enables TLSv1.2 signatures. This adds (GPL) code from polarssl's 
pkcs11.c to the ssl_polarssl.c file to do the signature selection.

These patches should apply cleanly to the master and 2.3 branches. I suggest
adding them to both branches as these 'fix a missing functionality issue' for
polarssl builds.

-Steffan


