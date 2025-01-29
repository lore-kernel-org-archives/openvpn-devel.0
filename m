Date: Wed, 29 Jan 2025 17:26:14 +0100 (CET)
Message-Id: <202501291626.50TGQEF0065820@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250128220932.2113-1-smittals@...2857...>
References: <20250128220932.2113-1-smittals@...2857...>
Subject: [Openvpn-devel] [PATCH applied] Re: Add compatibility to build
 OpenVPN with AWS-LC.
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
To: Shubham Mittal <smittals@...2857...>
Cc: openvpn-devel@lists.sourceforge.net

I have not tested this with AWS LC, just tested basic client side tests
with OpenSSL (work).  Arne is the master of "mostly compatible SSL 
libraries" so if he says this is fine, I'm happy to follow.

Your patch has been applied to the master branch.

commit aab1f862f42f300d4ee7fe9a971fd2ae474c53db
Author: Shubham Mittal
Date:   Tue Jan 28 14:09:32 2025 -0800

     Add compatibility to build OpenVPN with AWS-LC.

     Signed-off-by: Shubham Mittal <smittals@...2857...>
     Acked-by: Arne Schwabe <arne@...1227...>
     Message-Id: <20250128220932.2113-1-smittals@...2857...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg30682.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


