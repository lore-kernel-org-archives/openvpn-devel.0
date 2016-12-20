MIME-Version: 1.0
In-Reply-To: <1482173532-25132-1-git-send-email-davids@...515...>
References: <1482173532-25132-1-git-send-email-davids@...515...>
From: Steffan Karger <steffan@...1856...>
Date: Tue, 20 Dec 2016 20:16:20 +0100
Message-ID: <CAA1AbxL0Fi19_y=YaVRq2HP9bPCY2KSSNVAN1hpK8p4N9ENrOw@...278...>
Subject: Re: [Openvpn-devel] [PATCH] dev-tools: Added script for updating
 copyright years in files
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
To: David Sommerseth <davids@...515...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

On 19 December 2016 at 19:52, David Sommerseth <davids@...515...> wrote:
> Very simple tool which modifies the Copyright lines in all git checked-in
> files with an updated year.  Lines only listing a single year (2016) will
> be modified to list a range instead.

Good idea.

> +for file in $(git ls-files | grep -v cmocka);

Should 'cmocka' here be just 'vendor/'?

Otherwise this looks good to me, so once you've considered the above, ACK.

-Steffan

