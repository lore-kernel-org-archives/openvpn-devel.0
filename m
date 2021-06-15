References: <c80d31ca-bee5-9194-c288-999754eb709a@...2610...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <a226b338-1e01-2525-202d-ea3fc49a487c@...2080...>
Date: Tue, 15 Jun 2021 20:44:40 +0200
MIME-Version: 1.0
In-Reply-To: <c80d31ca-bee5-9194-c288-999754eb709a@...2610...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] PID is deleted unconditionally on exit
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Matthias May <matthias.may@...2610...>, gert@...1296..., openvpn-devel@lists.sourceforge.net

On 12/05/2021 22:02, Matthias May via Openvpn-devel wrote:
> Hi Gert
> 
> We recently updated OpenVPN to 2.5.2 and found that the PID
> is since [1] unconditionally deleted when OpenVPN exits.
> This breaks OpenVPN in our init.

What kind of init system is this?  On what kind of distribution?


-- 
kind regards,

David Sommerseth
OpenVPN Inc


