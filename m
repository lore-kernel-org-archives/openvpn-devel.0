From: Kristof Provost <kprovost@...2661...>
Date: Thu, 24 Feb 2022 17:55:55 +0100
Message-Id: <20220224165557.22060-1-kprovost@...2661...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH DCO]: FreeBSD DCO support
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
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

Here's the current version of the patch to add FreeBSD DCO support.

The first patch isn't strictly related to FreeBSD, but fixes what I
think is a generic issue. It doesn't manifest with Linux because the
Linux DCO driver allows control packets to continue through normal UDP
processing. We don't do that in FreeBSD, so it manifests there.

I've had to add a lot of '|| defined(TARGET_FREEBSD)', and I think the
code could be a bit cleaner if we'd make these calls conditional only on
defined(ENABLE_DCO), and instead expect every DCO implementation to
provide them, if only as stubs. I've not done that here.

For those interested in testing, the kernel side of things is under
review here: https://reviews.freebsd.org/D34340

Best,
Kristof



