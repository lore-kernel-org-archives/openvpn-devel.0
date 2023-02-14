Date: Tue, 14 Feb 2023 15:56:21 +0100 (CET)
Message-Id: <202302141456.31EEuLpr024050@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20230201230340.2268781-1-selva.nair@...277...>
References: <20230201230340.2268781-1-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: cryptoapi.c: remove pre
 OpenSSL-3.01 support
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
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

This patch looks large and complex, but all it does do is "rip out code
parts that are inside #ifndef HAVE_XKEY_PROVIDER" (plus add a message
as replacement).  This is a welcome change, and in line with what we
discussed some time ago regarding OpenSSL support for windows builds.

Applying this to the release/2.6 branch is bending the project rules
for "what goes into a release branch" slightly, but we're still in
2.6.*0* and there is lots of cleanup going on - and, really, this is
"long term support" since we do not intend to ever provide 2.6.x 
installers with pre-3.0 OpenSSL libraries, so it's (for all "the project"
cares) dead code anyway.

Noter: this does not break compilation with 1.1.1, just remove cryptoapi
support (https://github.com/cron2/openvpn/actions/runs/4174981083).

Your patch has been applied to the master and release/2.6 branch.

commit 4b28831e07a357476cb31a6f439becff3dc8c842 (master)
commit f3dd050ed8d95001107a841fa7779d09f3efb944 (release/2.6)
Author: Selva Nair
Date:   Wed Feb 1 18:03:40 2023 -0500

     cryptoapi.c: remove pre OpenSSL-3.01 support

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20230201230340.2268781-1-selva.nair@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg26131.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


