Date: Mon, 4 Aug 2025 11:15:28 +0200 (CEST)
Message-Id: <202508040915.5749FShT008150@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250804091027.13509-1-gert@...1296...>
References: <20250804091027.13509-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Disable clang-format for some
 code parts
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
To: Frank Lichtenheld <frank@...2641...>
Cc: openvpn-devel@lists.sourceforge.net

What it says... this just adds 2x two magic comments that tell clang-format
"leave this section alone".  Sometimes table-like stuff just doesn't work
very well with auto-formatting...

Your patch has been applied to the master branch.

commit d22f247d6c68283526ddd4ce32ab677209bf56e0
Author: Frank Lichtenheld
Date:   Mon Aug 4 11:10:21 2025 +0200

     Disable clang-format for some code parts

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20250804091027.13509-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg32492.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


