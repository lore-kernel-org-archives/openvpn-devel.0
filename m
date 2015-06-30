Message-ID: <5592F0BF.5080900@...1856...>
Date: Tue, 30 Jun 2015 21:40:47 +0200
From: Steffan Karger <steffan@...1856...>
MIME-Version: 1.0
References: <1435611582-26553-1-git-send-email-steffan@...1856...>	<55922E18.2060204@...1227...>	<20150630075727.GO382@...1296...>
	<20150630120242.GR382@...1296...>
In-Reply-To: <20150630120242.GR382@...1296...>
Subject: Re: [Openvpn-devel] [PATCH] Increase control channel packet size
 for faster handshakes
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net


On 30-06-15 14:02, Gert Doering wrote:
> ... and while I have the magic wand, another wish .-) - please log a
> message what MTU we've decided to use.  We *will* see "it does not work!"
> log files and that might help...

Sure!  I just compiled it into your local binary.  Just use --verb 4 and 
a line like

    Control Channel MTU parms [ L:1541 D:1184 EF:66 EB:0 ET:0 EL:3 ]

will be appear to report the calculated MTU ;)

-Steffan

Spoiler: frame_print() is already called from do_init_finalize_tls_frame().

