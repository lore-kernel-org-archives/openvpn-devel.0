Message-ID: <53A9A418.2090103@...1516...>
Date: Tue, 24 Jun 2014 18:15:20 +0200
From: Holger Kummert <Holger.Kummert@...1516...>
MIME-Version: 1.0
References: <1397645317-20116-1-git-send-email-Holger.Kummert@...1516...>	<1397645317-20116-2-git-send-email-Holger.Kummert@...1516...>	<20140602182009.GP1118@...1296...>	<538F27C6.2030203@...1516...>
	<53A14B09.8010405@...1516...> <53A1FF99.1000001@...1114...>
In-Reply-To: <53A1FF99.1000001@...1114...>
Subject: Re: [Openvpn-devel] [PATCH 1/2] Get NTLMv1 compatibilities and
 NTLMv2 up and running
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net


So the vote goes clearly to #defines, right?

I'm going to change the code and test it. If it works, the change will
be included in the next patch.


Best regards,
Holger


Am 18.06.2014 23:07, schrieb David Sommerseth:
> I see and understands the arguments for using static const, and it
> surely have it's advantages.  However, the OpenVPN code base, which
> dates back over a decade, has used the #define approach.  This is
> probably one of the really few things where the code base is quite
> consistent.  I prefer that we try to be somewhat consistent with what
> most of the already existing code uses.
>
> Even though the coding style can be quite inconsistent in parts of the
> code base, I prefer that we don't add more inconsistency.
>
> If we at some point find the advantages with static const to really be
> superior to #define, then we should switch most of the code base to that
> style.  But that's a different discussion, as this just as well requires
> compatibility testing with preprocessors and compilers across several
> platforms.
>
>

