Date: Thu, 17 Jan 2019 17:12:59 +0100 (CET)
Message-Id: <201901171612.x0HGCxwb092413@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20181016102627.18676-2-simon@...2293...>
References: <20181016102627.18676-2-simon@...2293...>
Subject: [Openvpn-devel] [PATCH applied] Re: Prevent __stdcall name mangling
 of MSVC
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

"LGTM" from Jon (plus patch and explanation seem to make sense :-) )

commit 7d08c33cfc58eeb7286446c8d1ffd02939782332
Author: Simon Rozman
Date:   Tue Oct 16 12:26:24 2018 +0200

     Prevent __stdcall name mangling of MSVC

Acked-by: Jon Kunkee <jkunkee@...2393...>
     Message-Id: <20181016102627.18676-2-simon@...2293...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg17765.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


