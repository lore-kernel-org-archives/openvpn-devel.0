MIME-Version: 1.0
In-Reply-To: <20171114083134.GV958@...1296...>
References: <20171110163946.7656-1-fkooman@...2318...>
 <63ccd0e3-491f-3fb3-e611-9b6674d3d501@...2298...>
 <aef485c7-f619-eaac-6534-0828ab9d41f5@...2318...>
 <CAKuzo_jfJQOBhYMEyT4oiNN1xAZkvkxZm8eeDT=xcUfToaC9kQ@...278...>
 <20171112214244.GI958@...1296...>
 <34a7cc97-16e2-becc-4f97-ff8dbf8ecb0a@...2318...>
 <4ea94797-c52a-da17-b5ba-c7f8d9411326@...2181...>
 <4717a1f2-b8c6-26ae-2cf4-42ae5f34c3eb@...1435...>
 <6ad9db3e-63b5-78fe-0105-81c92746feb2@...2080...>
 <20171114083134.GV958@...1296...>
From: "Jonathan K. Bullard" <jkbullard@...277...>
Date: Tue, 14 Nov 2017 07:01:34 -0500
Message-ID: <CAEsd45R+WEd+sC1xdaGFcTVDfA_OT_zoJFbTV8xuOMXTsNCvfA@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Implement "status 4" (JSON) for
 management interface
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
To: Gert Doering <gert@...1296...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi,

On Tue, Nov 14, 2017 at 3:31 AM, Gert Doering <gert@...1296...> wrote:
> Hi,
>
> On Mon, Nov 13, 2017 at 01:16:46PM +0100, David Sommerseth wrote:
>> But we should consider if we want to make use of a JSON library
>> producing the JSON streams.  The reason is to ensure the output is
>> according to the specification and that escaping if contents is
>> consistent and proper.  Imagine if someone puts a double-quote into the
>> CN field of a certificate?
>>
>>  CN="} Lets explode things, O=Hacktivist0
>>
>> Or other characters which needs escaping.
>
> I'm not convinced we want to import a new library dependency and a heap
> of #ifdef for this.
>
> Escaping on *output* is pretty trivial ("characters from <this set>
> need to be encoded <like this>") - and as long as we do not need to parse
> *incoming* JSON, a full-blown new library is mainly adding complications
> (like, configure flags, #ifdefs, library version dependencies, ...).

+1

Best regards,

Jon Bullard

