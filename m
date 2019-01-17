Date: Thu, 17 Jan 2019 17:26:33 +0100 (CET)
Message-Id: <201901171626.x0HGQXSA092661@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20181016102627.18676-4-simon@...2293...>
References: <20181016102627.18676-4-simon@...2293...>
Subject: [Openvpn-devel] [PATCH applied] Re: Add MSI custom action for
 reliable Windows 10 detection
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
To: Simon Rozman <simon@...2293...>
Cc: openvpn-devel@lists.sourceforge.net

Your patch has been applied to the master branch.

"LGTM" from Jon after quite some discussion.  I'm not trying to understand
the intricacies of the code, just some basic sanity checking ("no chance
this will scribble over a registry entry or execute unwanted binaries
by means of an uninitialized buffer").

commit e2faae87b49379ce8bcffb2f0ae67b0671996f64
Author: Simon Rozman
Date:   Tue Oct 16 12:26:26 2018 +0200

     Add MSI custom action for reliable Windows 10 detection

Acked-by: Jon Kunkee <jkunkee@...2393...>
     Message-Id: <20181016102627.18676-4-simon@...2293...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg17763.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


