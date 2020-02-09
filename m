References: <20200207174818.21050-1-juliusz@...2525...>
 <20200208084558.GV1431@...1296...>
 <23330b19-35b6-7e4e-2f2e-9c3c1626f53d@...2525...>
 <fb9901f1-d304-ca31-cd9c-23712f320bd3@...2181...>
 <20200209095039.GY1431@...1296...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <6bcc2555-feb9-aff5-ccdb-b2d1f8d1295b@...2181...>
Date: Sun, 9 Feb 2020 10:51:21 +0100
MIME-Version: 1.0
In-Reply-To: <20200209095039.GY1431@...1296...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH] Support for wolfSSL with OpenVPN master
 branch
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: Gert Doering <gert@...1296...>
Cc: Juliusz Sosinowicz <juliusz@...2525...>, openvpn-devel@lists.sourceforge.net

Hi,

On 09/02/2020 10:50, Gert Doering wrote:
> Hi,
> 
> On Sun, Feb 09, 2020 at 10:44:48AM +0100, Antonio Quartulli wrote:
>> if wolfssl support is being introduced by means of the openssl
>> compatibility layer, why do people need to configure OpenVPN with
>> "./configure --with-crypto-library=wolfssl", rather than just using
>> openssl and specifying a different path for headers/libraries?
>>
>> Isn't the compat layer in wolfssl operating as a drop-in replacement for
>> openssl?
> 
> This question has been asked before and answered :-) - most of the
> compat functions seem to be implemented as macros, which our configure
> will not find.  So, configure needs to explicitely define what is there
> and what not.
> 
> I do not like the extra include very much, but that seems to be hard 
> to avoid with the current WolfSSL header file setup.
> 

ouch, thanks for the reminder :-)



-- 
Antonio Quartulli

