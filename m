References: <CAFHpkQFzOBMUC+qX7vV8jeHxg2MdP6_DCwiUZ=seX7r3DE=cBg@...278...>
 <20210309124712.GJ976@...1296...>
 <CAFHpkQFqD4HqThaURqi1dCXhjsthDwWg81LdNP4BVWGfGgk_Lg@...278...>
 <20210309125602.GK976@...1296...>
 <CAFHpkQHVGuwiGfAwUsnbPXH47Cj5BHO0V9ep6Dt1EvV9M19mFQ@...278...>
 <20210309132846.GM976@...1296...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <80ac443f-e36f-6a62-c162-a4d47bb3b59c@...2080...>
Date: Tue, 9 Mar 2021 16:05:30 +0100
MIME-Version: 1.0
In-Reply-To: <20210309132846.GM976@...1296...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] using openssl feature wherever possible
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
To: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Cc: openvpn-devel@lists.sourceforge.net

On 09/03/2021 14:28, Gert Doering wrote:
> Hi,
> 
> On Tue, Mar 09, 2021 at 06:26:08PM +0500, ???????? ?????????????? wrote:
>> we may keep combo.
>> both #ifdef EVP_PKEY_TLS1_PRF and comment related to supported openssl
>> versions (to drop support if we decide)
> 
> We could, but we won't.
> 
> (I can see the benefits, but I'm not the one maintaining these code
> bits - Arne is, and he has stated a clear preference on doing it the
> way it is currently done)
> 

+1 ... This is really the right approach.

Either these "wannabe OpenSSL" libraries gets their act together and 
really do fully support the OpenSSL API they claim to be compliant to - 
and everything will work out just fine.  Otherwise they break with 
OpenVPN.  If they start playing fun games with the version macros 
originally defined by OpenSSL, it will break.  It's that easy.  We won't 
spend (waste) time playing their compatibility games.  If it breaks, 
it's their bug not ours.


-- 
kind regards,

David Sommerseth
OpenVPN Inc


