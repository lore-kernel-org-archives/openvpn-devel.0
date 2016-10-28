References: <1477650469-32431-1-git-send-email-janjust@...1147...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <67f3c1a0-8e94-b97e-2b9f-61ae81583c64@...1227...>
Date: Fri, 28 Oct 2016 13:08:05 +0200
MIME-Version: 1.0
In-Reply-To: <1477650469-32431-1-git-send-email-janjust@...1147...>
Subject: Re: [Openvpn-devel] [PATCH] Allow "setenv opt" to be pushed from
 server to client
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: Jan Just Keijser <janjust@...1147...>, openvpn-devel@lists.sourceforge.net

Hm,


I would like to see a rationale why this is needed. The client will
already only warn on unsupported options. Your patch would make push
"setenv opt unsupported" similar to "push unsupported".


Arne

