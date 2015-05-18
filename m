MIME-Version: 1.0
In-Reply-To: <CAEsd45RoxhHiXGTAQwaPHHPnqfMk=iHjkoJOzeU_WaSU72MKXQ@...278...>
References: <CAEsd45S8+hwK9mB53mVBLO-1NSJp7YE3tx53Am83pzDL+tr8GQ@...278...>
	<55464DBE.4010203@...1856...>
	<CAEsd45RoxhHiXGTAQwaPHHPnqfMk=iHjkoJOzeU_WaSU72MKXQ@...278...>
From: "Jonathan K. Bullard" <jkbullard@...277...>
Date: Mon, 18 May 2015 05:50:27 -0400
Message-ID: <CAEsd45RhgvCe42eRXiRk-XxODtdaqhdG3n9pautmA3s9KTuNFA@...278...>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: Steffan Karger <steffan@...1856...>, Gert Doering <gert@...1296...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

On Mon, May 4, 2015 at 9:26 AM, Jonathan K. Bullard wrote:
> If I have a
> configuration that has worked for many years I might be more likely to
> not notice one warning among all the output in a typical log at the
> default "verb 3" setting.

Correction: the default setting is "verb 1", not "verb 3".

However, almost all of the configurations I see from people
troubleshooting Tunnelblick include "verb 3", and eight of the ten
sample configuration files in OpenVPN 2.3.6 include "verb 3". So I
think my conclusions are still valid: a typical log includes a lot of
information and warnings are easily overlooked in a configuration that
was worked for years.

