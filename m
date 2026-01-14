Date: Wed, 14 Jan 2026 15:36:53 +0100 (CET)
Message-Id: <202601141436.60EEarV9032199@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20260113121512.12057-1-gert@...1296...>
References: <20260113121512.12057-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: socket: Remove old 'dynamic
 remote' feature
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

So for the sake of the archive, the feature removed here is

 - if resolving the --remote hostname on a TCP server(!) does not work,
   remember the hostname, and on TCP accept(), try re-resolving it again,
   and then verify that the IPs returned by getaddrinfo() match where the
   connect is coming from

since it was broken for a long time and nobody cared, this was obviously
obscure enough that "remove it, simplify the code fairly big time" is a
good plan.  Thanks Arne for the review, and I second that this is a good
idea ;-)  - mildly tested on a TCP server (which does not use --remote
today).

Your patch has been applied to the master branch.

commit d61d3c2a71136cee146ede8b834b460721dd8d23
Author: Frank Lichtenheld
Date:   Tue Jan 13 13:15:05 2026 +0100

     socket: Remove old 'dynamic remote' feature

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Arne Schwabe <arne-openvpn@...1227...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1468
     Message-Id: <20260113121512.12057-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg35232.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


