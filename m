Message-ID: <41626D3F.3070407@...289...>
From: Vlada Macek <tuttle@...289...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] Again: Feature implementation: Connection refusal
 based upon CN
References: <4161A650.1020706@...289...> <Pine.LNX.4.58.0410042230440.16439@...269...>
In-Reply-To: <Pine.LNX.4.58.0410042230440.16439@...269...>
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Tue Oct  5 02:52:39 2004
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

[Autor citovane zpravy: James Yonan, cas odeslani: 05.10.2004 07:14]

>I do have a concern though on your implementation.  You are conducting the
>allow/deny test in multi_connection_established(). The problem is that
>this function runs too late in the client instance initialization sequence
>to be able to securely deny authentication.
>  
>
I thought so, but I wasn't sure! :-) In case the patch will mature with
regard to your concern, is there a chance for the inclusion to the mainline?

If so, would you like to rename the option?

Thank you.

\//\/\


