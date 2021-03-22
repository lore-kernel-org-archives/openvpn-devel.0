References: <20210321144627.1621-1-simon@...2293...>
 <20210321165045.GY976@...1296...>
 <487884f67f874d438ca181de91399c52@...2293...>
 <20210322085411.GG976@...1296...>
 <CAGyAFMWGbuN-0x=V9DpGzL4w+fWhz6d=4ce0x5+cg3DN8HOzKw@...278...>
 <20210322095538.GK976@...1296...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <fd3da023-c4b3-0773-e3b6-581b24ff4a01@...1227...>
Date: Mon, 22 Mar 2021 13:34:10 +0100
MIME-Version: 1.0
In-Reply-To: <20210322095538.GK976@...1296...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] Visual Studio building for master/2.6 and LZ4
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
To: Gert Doering <gert@...1296...>, Lev Stipakov <lstipakov@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Am 22.03.21 um 10:55 schrieb Gert Doering:
> Hi,
> 
> (I have changed the Subject: line to make clear that this is a bigger
> topic now)
> 
> On Mon, Mar 22, 2021 at 11:51:46AM +0200, Lev Stipakov wrote:
>> For 2.6, I think we should drop openvpn-build for Windows (VS)
>> building and switch to vcpkg for dependencies (openssl, lz4 etc) and
>> cmake as a project file (also supported by VS).
> 
> I have no opinion there whatsoever...  please send patches & trac 
> documentation :-)

I have a very hacky CMakeLists.txt that works well enough to compile
with with Clion and MSVC. But the biggest hurdle is that I would need to
add pkcs11 to vckpg (and also clean up the cmakelists.txt) file. Also
that brings then two ways of building openvpn under Linux/mac/other
Unices, one with cmake and one with autoconf/automake and whole
discussion about build systems.

Arne


