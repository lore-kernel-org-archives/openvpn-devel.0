Message-ID: <2d460de70709100322m6cdd770bh566d825af7a33c7c@...278...>
Date: Mon, 10 Sep 2007 12:22:36 +0200
From: "Richard Hartmann" <richih.mailinglist@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] Revisit of a possible compile-time enabled
	pkcs11-pin option
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

Hi all,


as most, if not all, of you will be aware, there is an option to pass
the certificate passphrase into OpenVPN if you compile OpenVPN with the
correct option, yourself. This Molly Guard enables people who know what
they are doing to automate the process a little bit more than would be
possible, otherwise.

My request is that the same thing should be offered for the PKCS#11
interface of 2.1. The discussion about the relative merits of the
management console and compiling your own OpenVPN binaries
notwithstanding, I feel that this approach is more secure, less prone to
failure and eases the overall process a _lot_. Furthermore, this
question has already been discussed in the mailing list archives and,
back then, it was decided to go the path of Bake Your Own to safeguard
people against themselves, at least for the passphrase.

Is there any chance that this feature sees the light of day and if yes,
is anyone able and/or willing to venture a guess as to when this might
be the case?


Thank you for all the work on OpenVPN!
Richard

