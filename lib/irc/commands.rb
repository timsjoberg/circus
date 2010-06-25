module Circus
  class Commands
    class << self
    
      COMMAND_MAP = {
        # --- Text based ----------------------------------------
        "error"   =>  :ERROR,
        "invite"  =>  :INVITE,
        "join"    =>  :JOIN,
        "kick"    =>  :KICK,
        "kill"    =>  :KILL,
        "mode"    =>  :MODE,
        "nick"    =>  :NICK,
        "notice"  =>  :NOTICE,
        "part"    =>  :PART,
        "ping"    =>  :PING,
        "privmsg" =>  :PRIVMSG,
        "quit"    =>  :QUIT,



        # --- 0** Codes ----------------------------------------
        "001" => :WELCOME,
        "002" => :YOURHOST,
        "003" => :CREATED,
        "004" => :MYINFO,
        "005" => :ISUPPORT,



        # --- 2** Codes ----------------------------------------
        "200" => :TRACELINK,
        "201" => :TRACECONNECTING,
        "202" => :TRACEHANDSHAKE,
        "203" => :TRACEUNKNOWN,
        "204" => :TRACEOPERATOR,
        "205" => :TRACEUSER,
        "206" => :TRACESERVER,
        "207" => :TRACESERVICE,
        "208" => :TRACENEWTYPE,
        "209" => :TRACECLASS,
        "210" => :TRACERECONNECT,
        "211" => :STATSLINKINFO,
        "212" => :STATSCOMMANDS,
        "213" => :STATSCLINE,
        "214" => :STATSNLINE,
        "215" => :STATSILINE,
        "216" => :STATSKLINE,
        "217" => :STATSQLINE,
        "218" => :STATSYLINE,
        "219" => :ENDOFSTATS,
        "221" => :UMODEIS,
        "231" => :SERVICEINFO,
        "232" => :ENDOFSERVICES,
        "233" => :SERVICE,
        "234" => :SERVLIST,
        "235" => :SERVLISTEND,
        "240" => :STATSVLINE,
        "241" => :STATSLLINE,
        "242" => :STATSUPTIME,
        "243" => :STATSOLINE,
        "244" => :STATSHLINE,
        "245" => :STATSSLINE,	# RFC 2812 seems to be erroneous, it assigns 244 double
        "246" => :STATSPING,
        "247" => :STATSBLINE,
        "250" => :STATSCONN,
        "251" => :LUSERCLIENT,
        "252" => :LUSEROP,
        "253" => :LUSERUNKNOWN,
        "254" => :LUSERCHANNELS,
        "255" => :LUSERME,
        "256" => :ADMINME,
        "257" => :ADMINLOC1,
        "258" => :ADMINLOC2,
        "259" => :ADMINEMAIL,
        "261" => :TRACELOG,
        "262" => :TRACEEND,
        "263" => :TRYAGAIN,
        "265" => :LOCALUSERS,
        "266" => :GLOBALUSERS,
        "290" => :IDENTIFY,



        # --- 3** Codes ----------------------------------------
        "300" => :NONE,
        "301" => :AWAY,
        "302" => :USERHOST,
        "303" => :ISON,
        "305" => :UNAWAY,
        "306" => :NOWAWAY,
        "311" => :WHOISUSER,
        "312" => :WHOISSERVER,
        "313" => :WHOISOPERATOR,
        "314" => :WHOWASUSER,
        "315" => :ENDOFWHO,
        "316" => :WHOISCHANOP,
        "317" => :WHOISIDLE,
        "318" => :ENDOFWHOIS,
        "319" => :WHOISCHANNELS,
        "320" => :IDENTIFIED_TO_SERVICES,
        "321" => :LISTSTART,
        "322" => :LIST,
        "323" => :LISTEND,
        "324" => :CHANNELMODEIS,
        "325" => :UNIQOPIS,
        "328" => :UNK_328, # freenode.net, on join
        "329" => :CHANNEL_INFO,
        "331" => :NOTOPIC,
        "332" => :TOPIC,
        "333" => :TOPIC_INFO,
        "341" => :INVITING,
        "342" => :SUMMONING,
        "343" => :MAINTENANCE,
        "346" => :INVITELIST,
        "347" => :ENDOFINVITELIST,
        "348" => :EXCEPTLIST,
        "349" => :ENDOFEXCEPTLIST,
        "351" => :VERSION,
        "352" => :WHOREPLY,
        "353" => :NAMEREPLY,
        "361" => :KILLDONE,
        "362" => :CLOSING,
        "363" => :CLOSEEND,
        "364" => :LINKS,
        "365" => :ENDOFLINKS,
        "366" => :ENDOFNAMES,
        "367" => :BANLIST,
        "369" => :ENDOFWHOWAS,
        "368" => :ENDOFBANLIST,
        "371" => :INFO,
        "372" => :MOTD,
        "373" => :INFOSTART,
        "374" => :ENDOFINFO,
        "375" => :MOTDSTART,
        "376" => :ENDOFMOTD,
        "381" => :YOUREOPER,
        "382" => :REHASHING,
        "383" => :YOURESERVICE,
        "384" => :MYPORTIS,
        "391" => :TIME,
        "392" => :USERSSTART,
        "393" => :USERS,
        "394" => :ENDOFUSERS,
        "395" => :NOUSERS,
        "396" => :HOSTHIDDEN, # undernet [ircu]: when hiding host is activated



        # --- 4** Codes ----------------------------------------
        "401" => :NOSUCHNICK,
        "402" => :NOSUCHSERVER,
        "403" => :NOSUCHCHANNEL,
        "404" => :CANNOTSENDTOCHAN,
        "405" => :TOOMANYCHANNELS,
        "406" => :WASNOSUCHNICK,
        "407" => :TOOMANYTARGETS,
        "408" => :NOSUCHSERVICE,
        "409" => :NOORIGIN,
        "410" => :SERVICES_OFFLINE,
        "411" => :NORECIPIENT,
        "412" => :NOTEXTTOSEND,
        "413" => :NOTOPLEVEL,
        "414" => :WILDTOPLEVEL,
        "415" => :BADMASK,
        "421" => :UNKNOWNCOMMAND,
        "422" => :NOMOTD,
        "423" => :NOADMININFO,
        "424" => :FILEERROR,
        "431" => :NONICKNAMEGIVEN,
        "432" => :ERRONEUSNICKNAME,
        "433" => :NICKNAMEINUSE,
        "436" => :NICKCOLLISION,
        "437" => :UNAVAILRESOURCE,
        "441" => :USERNOTINCHANNEL,
        "442" => :NOTONCHANNEL,
        "443" => :USERONCHANNEL,
        "444" => :NOLOGIN,
        "445" => :SUMMONDISABLED,
        "446" => :USERSDISABLED,
        "451" => :NOTREGISTERED,
        "461" => :NEEDMOREPARAMS,
        "462" => :ALREADYREGISTRED,
        "463" => :NOPERMFORHOST,
        "464" => :PASSWDMISMATCH,
        "465" => :YOUREBANNEDCREEP,
        "466" => :YOUWILLBEBANNED,
        "467" => :KEYSET,
        "471" => :CHANNELISFULL,
        "472" => :UNKNOWNMODE,
        "473" => :INVITEONLYCHAN,
        "474" => :BANNEDFROMCHAN,
        "475" => :BADCHANNELKEY,
        "476" => :BADCHANMASK,
        "477" => :NOCHANMODES,
        "478" => :BANLISTFULL,
        "481" => :NOPRIVILEGES,
        "482" => :CHANOPRIVSNEEDED,
        "483" => :CANTKILLSERVER,
        "484" => :RESTRICTED,
        "485" => :UNIQOPPRIVSNEEDED,
        "491" => :NOOPERHOST,
        "492" => :NOSERVICEHOST,



        # --- 5** Codes ----------------------------------------
        "501" => :UMODEUNKNOWNFLAG,
        "502" => :USERSDONTMATCH,
        "505" => :NOPRIVMSG,
        
        
        
        # --- 9** Codes ----------------------------------------
        "901" => :UNK_901 # irc.freenode.net: response to identification (/msg nickserv identify <pass>)
      }
      
      COMMAND_LIST = COMMAND_MAP.values
      
      def get_command_symbol(command)
        return COMMAND_MAP[command.downcase] if COMMAND_MAP[command.downcase]
        nil
      end
      
      def is_valid_symbol?(symbol)
        COMMAND_LIST.include? symbol
      end
    
    end
  end
end
