Message-ID: <555A55E8.8070403@...1856...>
Date: Mon, 18 May 2015 23:13:12 +0200
From: Steffan Karger <steffan@...1856...>
MIME-Version: 1.0
References: <CAEsd45S8+hwK9mB53mVBLO-1NSJp7YE3tx53Am83pzDL+tr8GQ@...278...>
	<55464DBE.4010203@...1856...>
	<CAEsd45RoxhHiXGTAQwaPHHPnqfMk=iHjkoJOzeU_WaSU72MKXQ@...278...>
	<555893F1.9080207@...1856...> <20150517172423.GQ382@...1296...>
In-Reply-To: <20150517172423.GQ382@...1296...>
Subject: Re: [Openvpn-devel] OpenVPN argument parsing of most options
 ignores "extra" parameters
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
To: Gert Doering <gert@...1296...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>


On 17-05-15 19:24, Gert Doering wrote:
> On Sun, May 17, 2015 at 03:13:21PM +0200, Steffan Karger wrote:
>> That sounds reasonable to me.  However, I tend to be easier in accepting
>> (potentially) breaking changes than other community members.  So I think
>> it makes sense to put this on the agenda for the next IRC meeting.
>> Iirc, the next one should be tomorrow at 20:00 CEST.
>
> +1 :-)
>
> I do not have strong feelings on whether this should be a warning or
> a hard error, but it's generally good practice to let the user know about
> "unexpected extra arguments" (or, turned around, totally annoying if
> software just ignores stuff on the command line without at least telling
> you) - so all for "doing something about it".

Quoting from Samuli's IRC meeting summary:

"Decided to make the config parser fail if erroneous extra options are 
encountered."

That is, there is agreement to get this into master / 2.4.  Patches are 
very welcome.

-Steffan

