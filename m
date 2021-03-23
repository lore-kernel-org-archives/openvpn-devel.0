References: <20210321144627.1621-1-simon@...2293...>
 <20210321165045.GY976@...1296...>
 <487884f67f874d438ca181de91399c52@...2293...>
 <20210322085411.GG976@...1296...>
 <CAGyAFMWGbuN-0x=V9DpGzL4w+fWhz6d=4ce0x5+cg3DN8HOzKw@...278...>
 <20210322095538.GK976@...1296...>
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <6f31bbaa-febd-0984-c62a-a109e1dfa54c@...515...>
Date: Tue, 23 Mar 2021 16:14:29 +0200
MIME-Version: 1.0
In-Reply-To: <20210322095538.GK976@...1296...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] Visual Studio building for master/2.6 and LZ4
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
To: Gert Doering <gert@...1296...>, Lev Stipakov <lstipakov@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Il 22/03/21 11:55, Gert Doering ha scritto:
> Hi,
> 
> (I have changed the Subject: line to make clear that this is a bigger
> topic now)
> 
> On Mon, Mar 22, 2021 at 11:51:46AM +0200, Lev Stipakov wrote:
>> For 2.6, I think we should drop openvpn-build for Windows (VS)
>> building and switch to vcpkg for dependencies (openssl, lz4 etc) and
>> cmake as a project file (also supported by VS).

I'm not opposed as this sounds more standard than what we have now 
(opevnpn-build/msvc). We can still cross-compile using 
openvpn-build/generic if we wish.

This could potentially simplify the automated Windows MSI build process. 
Right now with Linux + Windows in the mix things are very confusing and 
fragile.

> I have no opinion there whatsoever...  please send patches & trac
> documentation :-)
> 
> gert
> 
> 
> 
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
> 


