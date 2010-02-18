From: "Karl O. Pinc" <kop@...1206...>
Date: Thu, 18 Feb 2010 11:58:27 -0600
Message-Id: <1266515908-24807-1-git-send-email-kop@...1304...>
Subject: [Openvpn-devel] Make sample-scripts/verify-cn dynamic
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

Re: [PATCH] Change verify-cn so cn is no longer hardcoded in openvpn's config file

This patch should be easy to process.
A resubmission of the patch sent to this list on 04/23/2009.

The patch changes the verify-cn script sample
to be used with --tls-verify so that instead of having
to hardcode a cn to verify in the OpenVPN configuration file
the allowed cns may be written into a separate file.

This makes the process of verifying cns a whole
lot more dynamic, to the point where it is useful
in the real world.

One problem with this patch is that it is backwards
incompatible.  I did not bother keeping the original
calling interface as A) it's a sample script, and B) the
original's functionality seems useless
and equalivant functionality is easily available
with the new script.

The problem with the original is that there seems
little point in verifying a client's cn when all
the clients share one cn, as would have to be
the case when the cn is hardcoded into the openvpn
config file.

This patch applies against the testing allmiscs branch,
and should apply against any of the other testing
branches as well.

It works for me.  I've tested it throughly but not
used it extensively in production.

Regards,

Karl <kop@...1206...>
Free Software:  "You don't pay back, you pay forward."
                 -- Robert A. Heinlein



