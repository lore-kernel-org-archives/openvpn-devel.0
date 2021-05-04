References: <20210429171504.1081888-1-tincantech@...2282...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <0a188829-5a2c-362c-eb6f-61ffe657042d@...1227...>
Date: Tue, 4 May 2021 12:50:19 +0200
MIME-Version: 1.0
In-Reply-To: <20210429171504.1081888-1-tincantech@...2282...>
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
To: Richard T Bonhomme <stringvest88@...277...>, openvpn-devel@lists.sourceforge.net

Am 29.04.21 um 19:15 schrieb Richard T Bonhomme:
> From: string vest <stringvest88@...277...>
> 
> Under Windows, programmatically retrieving the parent process ID of
> the openvpn instance which called a script is practically impossible.
> The only sensible way, currently available, is to write a PID file.
> 
> This patch adds a single integer variable, named daemon_pid, to the
> script environment. The value of which is set to the openvpn process
> ID that called the script.
> 
> Providing this variable via the running openvpn process is more secure,
> faster and far less prone to user-error than using a PID file.

Could you explain why you need the process ID of the daemon? I am trying
to figure out why that is needed. I also don't understand the secure in
this context. What are you protecting yourself against? You are not
protecting your script being called from a malicious program as that
could lookup the PID of openvpn and just set the daemon_id variable.

Arne

