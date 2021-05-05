References: <20210429171504.1081888-1-tincantech@...2282...>
 <0a188829-5a2c-362c-eb6f-61ffe657042d@...1227...>
 <_HUflzeIntsfJCr8BbPWvJqUE4YsZ4mnoeBBWWAWz5wXnrnJDSOgFNA8jXs4BX8W8rVR0-mttPOc8wCQ1Ou96EEB2a-ytMFQs33l9yGgwIU=@protonmail.com>
From: Arne Schwabe <arne@...1227...>
Message-ID: <635b6cff-1742-e69d-fe91-fc33a5495a7f@...1227...>
Date: Wed, 5 May 2021 09:51:43 +0200
MIME-Version: 1.0
In-Reply-To: <_HUflzeIntsfJCr8BbPWvJqUE4YsZ4mnoeBBWWAWz5wXnrnJDSOgFNA8jXs4BX8W8rVR0-mttPOc8wCQ1Ou96EEB2a-ytMFQs33l9yGgwIU=@protonmail.com>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [PATCH] Add daemon_pid to --tls-crypt-v2-verify
 environment
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: tincantech <tincantech@...2282...>
Cc: Richard T Bonhomme <stringvest88@...277...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>


>> Could you explain why you need the process ID of the daemon? I am trying
>> to figure out why that is needed. I also don't understand the secure in
>> this context. What are you protecting yourself against? You are not
>> protecting your script being called from a malicious program as that
>> could lookup the PID of openvpn and just set the daemon_id variable.
> 
> 
> The reason I am using the process ID is as follows:
> 
> When --tls-crypt-v2-verify is executed, it saves a file named:
> $(certificate_serial_number}.${daemon_pid}
> with data from the TLS-Crypt-V2 key metadata field, which can then
> be read by the following scripts: --tls-verify and --client-connect.
>

I can get behind the need of needing something daemon specific when
running multiple daemon that scripts/plugins need something simple to
identify a specific daemon. With management and a persistent connection
that is easier to implicitly assign an ID but for scripts daemon_pid
seems to be a good fit.

So if we make that a bit clear in the commit message this gets an ACK
from me.

Arne

