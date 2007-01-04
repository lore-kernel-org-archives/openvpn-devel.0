From: Charles Duffy <cduffy@...294...>
Date: Thu, 04 Jan 2007 13:29:48 -0600
Message-ID: <enjkjg$1jt$1@...165...>
References: <BAY128-F45C517531BF7DF7C034029CB90@...512...>
Mime-Version: 1.0
In-Reply-To: <BAY128-F45C517531BF7DF7C034029CB90@...512...>
Sender: news <news@...165...>
Subject: Re: [Openvpn-devel] OpenVPN Status Log
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net
Cc: openvpn-users@lists.sourceforge.net

Alexander Littell wrote:
> How difficult would it be to program the openvpn-status.log to show 
> usernames instead of common names?  Or maybe both.  Any thoughts on how to 
> do this?
> 
> I could be wrong, but I would guess that most OpenVPN administrators are 
> using username/password pairs instead of certificates to authenticate their 
> clients.  Well, I do anyway. :)

I'm assuming "openvpn-status.log" is the file created by the status 
directive (different folks can call it different things -- and it has 
two different formats available). I believe that already *will* show 
usernames if you have username-as-common-name specified; is this 
understanding incorrect?

In any event, while I request both usernames and certificates, the 
certificates are more useful in logs (as our certificates specify an 
individual machine as well as the user who owns that machine, whereas 
the usernames specify only the individual who owns the machine but not 
the specific host).

Are you using username-as-common-name? How about duplicate-cn? (It's 
much better to have unique certificates -- but if you're authenticating 
by username and aren't using certificates properly, using 
username-and-common-name and not duplicate-cn should give you more 
management control than using duplicate-cn and leaving off 
username-as-common-name, as in this latter case you can't identify 
individual clients for disconnect commands or such).


I think that this subthread belongs in openvpn-users rather than 
openvpn-devel. I'm sending it to both; please reply only in openvpn-users.


