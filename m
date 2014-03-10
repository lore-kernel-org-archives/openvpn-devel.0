Message-ID: <531D8573.4070409@...1227...>
Date: Mon, 10 Mar 2014 10:27:15 +0100
From: Arne Schwabe <arne@...1227...>
MIME-Version: 1.0
References: <CAGyAFMV8XBgiVKHB1n-fhycPOKCMyZkyQtnit7aUQ02yHDLRrA@...278...>
In-Reply-To: <CAGyAFMV8XBgiVKHB1n-fhycPOKCMyZkyQtnit7aUQ02yHDLRrA@...278...>
Subject: Re: [Openvpn-devel] New frame format with session ID
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Lev Stipakov <lstipakov@...277...>, openvpn-devel@lists.sourceforge.net

Am 10.03.14 09:52, schrieb Lev Stipakov:
> Hi guys,
>
> I've read January's IRC meeting minutes and there was a discussion
> about new frame format with session id.
>
> Is there any progress in this field so far? If James or someone happen
> to have time to document a new format, would be nice to see it.
>
No, nothing so far. I volunteered to implement the new format but I
haven't had time yet.

Current working hypothesis of me is:

d1-dn are data byte, s1 -s8 are session id bytes

DATA_V2:

[opcode][d2][d3]....[dn][d1]

and

DATA_SESSION_ID:

[opcode][s2][s3]...[s8][d1]...[dn][s1]

Arne

