References: <1478636302-9678-1-git-send-email-steffan.karger@...1435...>
	<1478636302-9678-4-git-send-email-steffan.karger@...1435...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <34c4a18c-5bdb-71a2-5248-c52d65ceeb68@...1227...>
Date: Sun, 13 Nov 2016 11:42:15 -0500
MIME-Version: 1.0
In-Reply-To: <1478636302-9678-4-git-send-email-steffan.karger@...1435...>
Subject: Re: [Openvpn-devel] [PATCH 3/5] Add missing includes in error.h
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
To: Steffan Karger <steffan.karger@...1435...>, openvpn-devel@lists.sourceforge.net

Am 08.11.16 um 15:18 schrieb Steffan Karger:
> error.h depends on these, but is apparently never used by files that do
> not include them.  When implementing the --tls-crypt unit tests, I ran
> into this.
> 

ACK



