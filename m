Date: Mon, 24 Mar 2025 22:15:09 +0100 (CET)
Message-Id: <202503242115.52OLF9Nq099914@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250324182735.12657-1-gert@...1296...>
References: <20250324182735.12657-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Make 'lport 0' no longer
 sufficient to do '--bind'.
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
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

Tested this with various combinations of --port, --bind, --lport, 
--local <v4|v6>, etc. - a fascinating world of interesting effects.

I've fixed a small oversight in the commit message - the line needs to
read

  Summary:  socket bind is now only done if one of these is set
    - --lport <port> with <port> not "0"

(with "--lport", as "--port" never leads to an automatic bind)

Also added a reference to GH schwabe/ics-openvpn#1794 where half the
problems go away if "lport 0" is removed from the config - which, in
these cases, translates to "is not enabling --bind" (the real issue
is "any" bind AF vs. getaddrinfo(), but not binding at all helps).

Patch has been applied to the master branch.

commit c91948a0e03f0ad03e7fdde59ed9fce87ba00885
Author: Gert Doering
Date:   Mon Mar 24 19:27:26 2025 +0100

     Make 'lport 0' no longer sufficient to do '--bind'.

     Signed-off-by: Gert Doering <gert@...1296...>
     Acked-by: Arne Schwabe <arne-openvpn@...1227...>
     Message-Id: <20250324182735.12657-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg31222.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


