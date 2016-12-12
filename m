References: <20161209181303.20267-1-list@...1798...>
	<20161212194442.GQ78624@...1296...>
	<1481579532.219495524@...2212...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <e1f14dbc-c8ef-c2bd-314b-8206fde90371@...1227...>
Date: Mon, 12 Dec 2016 23:27:06 +0100
MIME-Version: 1.0
In-Reply-To: <1481579532.219495524@...2212...>
Subject: Re: [Openvpn-devel] [PATCH 1/1] add more security features for
 systemd units
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
To: SviMik <svimik@...450...>, Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net


>>
>> (I do not think an openvpn *client* config will need a to create
>> files, but this needs testing)
>>

No, it does not. You compile with CLIENT_ONLY the tmp-dir option will
throw an error.

Arne

