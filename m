References: <1480466372-2396-1-git-send-email-selva.nair@...277...>
	<201611301858.uAUIwRPD071804@...2054...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <bcec447a-d77b-996e-e1ed-b2daf9a88696@...1227...>
Date: Wed, 30 Nov 2016 23:06:02 +0100
MIME-Version: 1.0
In-Reply-To: <201611301858.uAUIwRPD071804@...2054...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Force 'def1' method when
 --redirect-gateway is done through service
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
To: Gert Doering <gert@...1296...>, Selva Nair <selva.nair@...277...>
Cc: openvpn-devel@lists.sourceforge.net

Am 30.11.16 um 19:58 schrieb Gert Doering:
> ACK, thanks.
> 
> The patch does what we agreed on in the trac ticket ("no user changes"
> for the normal case, and "in the service pipe change, imply def1 if
> no flags set").  This is very little extra code and easily checked,
> while fixing this in other ways would need much more code - for a sort-of
> historic approach to routing table handling (we really shouldn't be
> *removing* other people's routes, and we don't do that for IPv6 either).
> 
> Semi-ACK on the approach from Arne ("that's what we do on Android") :-)

Slight correction. We actually set 0.0.0.0/0 on Android but Android
*always* translates that into a 0.0.0.0/1 and a 128.0.0.0/1 rule.

We could do the same and do the translation in the interactive service
instead of OpenVPN itself.

Arne


