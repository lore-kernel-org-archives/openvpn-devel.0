MIME-Version: 1.0
In-Reply-To: <20160421172555.GI53051@...1296...>
References: <B32C1FDE-D0CF-49A7-A231-28267BB89B46@...2127...>
	<CAA1AbxL3ZRGrig+j9uTdn17NDaM=WGbE4XgZf1nAyvXBxTwfBg@...278...>
	<A4F03DE4-3E70-4815-B4B4-CC185E35CF2C@...2127...>
	<20160421172555.GI53051@...1296...>
Date: Thu, 21 Apr 2016 19:33:28 +0200
Message-ID: <CAA1Abx+TtK5q3KPshyeLSWYY_u2v_MC9=bmJDgVGosBoNF-dHA@...278...>
From: Steffan Karger <steffan@...1856...>
Content-Type: multipart/alternative; boundary=001a113dc9a2bae4d60531021bcf
Subject: Re: [Openvpn-devel] [PATCH] auth-pam:Fix buffer overflow by user
 supplied data
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: Jens <openvpn-devel@...2127...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--001a113dc9a2bae4d60531021bcf
Content-Type: text/plain; charset=UTF-8

On 21 Apr 2016 7:25 p.m., "Gert Doering" <gert@...1296...> wrote:
> ... you need to #include <stdint.h> to get that symbol...
>
> Steffan: for the sake of "avoid yet another full loop and a v3", could
> you just ACK this change as well?

Yes, ACK.

-Steffan

--001a113dc9a2bae4d60531021bcf
Content-Type: text/html; charset=UTF-8

<p dir="ltr"><br>
On 21 Apr 2016 7:25 p.m., &quot;Gert Doering&quot; &lt;<a href="mailto:gert@...1296...">gert@...1296...</a>&gt; wrote:<br>
&gt; ... you need to #include &lt;stdint.h&gt; to get that symbol...<br>
&gt;<br>
&gt; Steffan: for the sake of &quot;avoid yet another full loop and a v3&quot;, could<br>
&gt; you just ACK this change as well?</p>
<p dir="ltr">Yes, ACK.</p>
<p dir="ltr">-Steffan</p>

--001a113dc9a2bae4d60531021bcf--

