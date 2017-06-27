MIME-Version: 1.0
From: Guido Vranken <guidovranken@...277...>
Date: Tue, 27 Jun 2017 13:11:00 +0200
Message-ID: <CAO5O-EL5tuK-hT5nSq7Pcz4ZTvxFjUvOcNLUq3zcdXac0esO2g@...278...>
Subject: [Openvpn-devel] OpenVPN fuzzers released
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Here is the set of fuzzers used to find the recent vulnerabilities in OpenVPN:

https://github.com/guidovranken/openvpn/tree/fuzzing

Not all code is covered by this set; more fuzzers need to be written
in order to verify the overall security of OpenVPN. Hence, it is
conceivable that more vulnerabilities exist.

Guido

