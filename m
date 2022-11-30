Message-ID: <497c22cb-5140-595f-acd6-75637f59b3c3@...1227...>
Date: Wed, 30 Nov 2022 07:15:50 +0100
MIME-Version: 1.0
References: <20221129180534.657529-1-selva.nair@...277...>
 <20221129183756.657793-1-selva.nair@...277...>
 <Y4ZzzbGgy/pUHDN6@...1296...>
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <Y4ZzzbGgy/pUHDN6@...1296...>
Subject: Re: [Openvpn-devel] [PATCH v2] pull-filter: ignore leading "spaces"
 in option names
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
To: Gert Doering <gert@...1296...>, selva.nair@...277...
Cc: openvpn-devel@lists.sourceforge.net


Am 29.11.2022 um 22:04 schrieb Gert Doering:
> Hi,
>
> On Tue, Nov 29, 2022 at 01:37:56PM -0500, selva.nair@...277... wrote:
>> From: Selva Nair <selva.nair@...277...>
>>
>> It seems sometimes comma-separated pulled options have
>> an offending leading space. Not sure whether that is an error,
>> but the change here matches the behaviour of option parsing.
>>
>> v2: fix typo in commit message.
> I have seen this, but I'd really prefer to fix the pushing side.
>
> Which options have you seen this with?  I only observed with with
> "auth-token", which grows an extra leading space when being sent
> unsolicited.

I think since the client wants to ignore these option, we should add 
this to the client as well as you can other abuse this to work around a 
client that uses pull filter.

Arne


