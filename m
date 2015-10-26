From: Jason Haar <Jason_Haar@...1490...>
Message-ID: <562EBDA0.9010205@...1490...>
Date: Tue, 27 Oct 2015 12:56:16 +1300
MIME-Version: 1.0
Subject: [Openvpn-devel] any reason output_peer_info_env isn't in 2.3.8?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi there

I've been running on openvpn-git for some time (2.3.4-ish?) due to my
desire to rely on UV_* variables being passed from the client to the
server/router. Anyway, I saw some other "git" features I used were in
2.3.8, so I decided to try that and discovered it still doesn't have the
server components for parsing environment vars pushed by the client

Is there any reason that "feature" still isn't present? I mean - it's a
bug - there's no point in having the client support a feature that the
server can't even interpret?

-- 
Cheers

Jason Haar
Corporate Information Security Manager, Trimble Navigation Ltd.
Phone: +1 408 481 8171
PGP Fingerprint: 7A2E 0407 C9A6 CAF6 2B9F 8422 C063 5EBB FE1D 66D1


