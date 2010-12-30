Message-ID: <4D1CFF2B.6030006@...68...>
Date: Thu, 30 Dec 2010 22:52:43 +0100
From: Matthias Andree <matthias.andree@...68...>
MIME-Version: 1.0
References: <4D177C14.4040300@...1030...> <4D1CAE99.4050406@...68...>
	<4D1CF3E1.7080205@...1030...>
In-Reply-To: <4D1CF3E1.7080205@...1030...>
Subject: Re: [Openvpn-devel] [OpenVPN 2.1.4 BUG]: hard-coded values in
 Makefiles for down-root and auth-pam plugins prevent cross compilation
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Mr Dash Four <mr.dash.four@...1030...>
Cc: David Sommerseth <dazo@...384...>, openvpn-devel@lists.sourceforge.net

Am 30.12.2010 22:04, schrieb Mr Dash Four:
> 
>> I think it would be good to integrate this with automake if the whole
>> setup is
>> to be integrated and these plugins are supposed to be built more or
>> less officially.
>>   
> Yep, that's what I meant. Better still, autogen can be utilised to do
> the same thing, but automake is a good start.

Automake is what's already in place, so it seems diligent to reuse that
and not instigate new build fashions to a branch in maintenance mode
such as 2.1. :-)


