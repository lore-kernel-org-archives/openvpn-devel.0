Message-ID: <e9d1579d-f9c4-89c6-f2a3-b14b862588c1@...1227...>
Date: Tue, 27 Dec 2022 00:54:14 +0100
MIME-Version: 1.0
Content-Language: en-GB
References: <20210907223614.8574-1-selva.nair@...277...>
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <20210907223614.8574-1-selva.nair@...277...>
Subject: Re: [Openvpn-devel] [PATCH] Allow skipping multple remotes via
 management interface
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

Am 08.09.21 um 00:36 schrieb selva.nair@...277...:
> From: Selva Nair <selva.nair@...277...>
> 
> The mamangement command "remote SKIP" is extended with an
> optional parameter 'count' > 0. If count is greater than
> number of connection entries (len), count % len is used.
> On going past the index of the last connection entry,
> counting is restarted from the first connection entry.
> 
> Without this, use of management-query-remote from a UI is
> virtually impractical except when there are only a handful
> of remote entries. Skipping the entries one by one takes
> a long time when there are many entries to be skipped
> (~ 1 second per entry).  Use of "remote MOD" is not an
> option as change of protocol is not supported.
> 
> Management clients can determine the availablity of this

Should be availability (found my the squiggly line of Thunderbird :D)

> feature by checking that the management interface version
> is > 3. Older versions will ignore the count parameter and
> behave identically to using count = 1.

Acked-By: Arne Schwabe <arne@...1227...>

Arne


