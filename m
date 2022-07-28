Message-ID: <2e42dffe-ebbe-bf6c-95e3-aa5c7d7eac9a@...1227...>
Date: Thu, 28 Jul 2022 14:46:46 +0200
MIME-Version: 1.0
Content-Language: en-GB
References: <20220728034508.15180-1-selva.nair@...277...>
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <20220728034508.15180-1-selva.nair@...277...>
Subject: Re: [Openvpn-devel] [PATCH 1/2] Do not skip ERROR:/SUCCESS:
 response from management interface
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: selva.nair@...277..., openvpn-devel@lists.sourceforge.net

Am 28.07.22 um 05:45 schrieb selva.nair@...277...:
> From: Selva Nair <selva.nair@...277...>
> 
> Generally we expect a response of SUCCESS: or ERROR: to every
> command sent to the management interface. But, while in
> the management-hold state, sending "signal foo" returns only
> the following reply (with foo = SIGHUP, SIGUSR1 etc.):
> 
>> HOLD:Waiting for hold release:0
> 
> Fix by always responding
> 
> ERROR: signal 'foo' is currently ignored"
> followed by the above line.
> 
> Though this is seldom seen in practice[*], such violation of the
> protocol could stall clients like the GUI. So fix it.
> 
> [*] One way this happens is with SIGHUP sent before the daemon
> is on hold state which it enters before the SIGHUP is received.
> 
Acked-By: Arne Schwabe

