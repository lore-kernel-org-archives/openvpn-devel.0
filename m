MIME-Version: 1.0
References: <20211015175330.15760-1-selva.nair@...277...>
 <CAGyAFMXOARGy6qiftdN9WXi-saaiWB1nONMCrEo+3wLDpCTooQ@...278...>
In-Reply-To: <CAGyAFMXOARGy6qiftdN9WXi-saaiWB1nONMCrEo+3wLDpCTooQ@...278...>
From: Lev Stipakov <lstipakov@...277...>
Date: Mon, 18 Oct 2021 10:18:45 +0300
Message-ID: <CAGyAFMWw09LmXm6mED3NUwwFyTBCmqwaONWWHLm_VFYBo-LVXA@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Fix some more wrong defines in
 config-msvc.h
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
To: Selva <selva.nair@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

I am sorry, I need to take the ack back. Probably cron2 can fix it in place?

-#define ENABLE_DEBUG 1
+#define ENABLE_DEBUG 0

This doesn't really undef ENABLE_DEBUG. Can we just remove "-#define
ENABLE_DEBUG 1" ?

--
-Lev

